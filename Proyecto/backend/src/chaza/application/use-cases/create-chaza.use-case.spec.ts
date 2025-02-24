import { Test, TestingModule } from '@nestjs/testing';
import { CreateChazaUseCase } from '../use-cases/create-chaza.use-case';
// import { ChazaRepository } from '../../domain/ports/chaza.repository';
// import { UserRepository } from 'src/user/domain/ports/user.repository';
// import { ChazaBuilder } from 'src/chaza/domain/builders/chaza.builder';
// import { ErrorManager } from 'utils/ErrorManager';
// import { ChazaRepository } from '../../domain/ports/chaza.repository';

const mockChazaRepository = {
  createChaza: jest.fn(),
};

const mockUserRepository = {
  findUserById: jest.fn(),
};

describe('CreateChazaUseCase', () => {
  let useCase: CreateChazaUseCase;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        CreateChazaUseCase,
        { provide: 'IChazaRepository', useValue: mockChazaRepository },
        { provide: 'IUserRepository', useValue: mockUserRepository },
      ],
    }).compile();

    useCase = module.get<CreateChazaUseCase>(CreateChazaUseCase);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('debería crear una chaza exitosamente', async () => {
    const mockUser = { id: '123' };
    mockUserRepository.findUserById.mockResolvedValue(mockUser);
    mockChazaRepository.createChaza.mockResolvedValue(undefined);

    const result = await useCase.execute('Chaza 1', 'Desc', 'Ubicacion', 1, '123');

    expect(mockUserRepository.findUserById).toHaveBeenCalledWith('123');
    expect(mockChazaRepository.createChaza).toHaveBeenCalled();
    expect(result).toEqual({
      chaza: expect.objectContaining({
        nombre: 'Chaza 1',
        descripcion: 'Desc',
        ubicacion: 'Ubicacion',
        foto_id: 1,
        id_usuario: '123',
      }),
    });
  });

  it('debería lanzar un error si el usuario no existe', async () => {
    mockUserRepository.findUserById.mockResolvedValue(null);

    await expect(
      useCase.execute('Chaza 1', 'Desc', 'Ubicacion', 1, '123')
    ).rejects.toThrow('User not found');

    expect(mockUserRepository.findUserById).toHaveBeenCalledWith('123');
    expect(mockChazaRepository.createChaza).not.toHaveBeenCalled();
  });
});
