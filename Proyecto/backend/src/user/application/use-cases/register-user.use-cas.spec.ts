import { Test, TestingModule } from '@nestjs/testing';
import { RegisterUserUseCase } from '../use-cases/register-user.use-case';

const mockUserRepository = {
  findUserByEmail: jest.fn(),
  createUser: jest.fn(),
};

const mockAuthService = {
  hashPassword: jest.fn(),
  generateToken: jest.fn(),
};

describe('RegisterUserUseCase', () => {
  let useCase: RegisterUserUseCase;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        RegisterUserUseCase,
        { provide: 'IUserRepository', useValue: mockUserRepository },
        { provide: 'AuthService', useValue: mockAuthService },
      ],
    }).compile();

    useCase = module.get<RegisterUserUseCase>(RegisterUserUseCase);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('debería registrar un usuario correctamente', async () => {
    const mockEmail = 'test@example.com';
    const mockPassword = 'password123';
    const hashedPassword = 'hashedPassword123';
    const mockUserId = '12345';  // Agregar un ID simulado
    const mockToken = 'mockToken123';

    mockUserRepository.findUserByEmail.mockResolvedValue(null);
    mockAuthService.hashPassword.mockResolvedValue(hashedPassword);
    
    // Simulamos el usuario con un ID
    mockUserRepository.createUser.mockImplementation((user) => {
      user.id = mockUserId; // Se asigna manualmente el ID
      return Promise.resolve();
    });

    mockAuthService.generateToken.mockReturnValue(mockToken);

    const result = await useCase.execute(mockEmail, mockPassword);

    expect(mockUserRepository.findUserByEmail).toHaveBeenCalledWith(mockEmail);
    expect(mockAuthService.hashPassword).toHaveBeenCalledWith(mockPassword);
    expect(mockUserRepository.createUser).toHaveBeenCalled();
    expect(mockAuthService.generateToken).toHaveBeenCalledWith(mockUserId);
    expect(result).toEqual({
      user: {
        email: mockEmail,
        userid: mockUserId, // Ahora sí debería estar definido
      },
      token: mockToken,
    });
  });

  it('debería lanzar un error si el usuario ya existe', async () => {
    const mockEmail = 'test@example.com';
    const mockPassword = 'password123';

    mockUserRepository.findUserByEmail.mockResolvedValue({ email: mockEmail });

    await expect(useCase.execute(mockEmail, mockPassword)).rejects.toThrow(
      'User already exists'
    );

    expect(mockUserRepository.findUserByEmail).toHaveBeenCalledWith(mockEmail);
    expect(mockAuthService.hashPassword).not.toHaveBeenCalled();
    expect(mockUserRepository.createUser).not.toHaveBeenCalled();
  });
});
