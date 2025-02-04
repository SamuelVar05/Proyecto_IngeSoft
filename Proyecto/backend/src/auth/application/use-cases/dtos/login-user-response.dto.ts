import { RegisterUserResponseDto } from './register-user-response.dto';

export interface LoginUserResponseDto
  extends Pick<RegisterUserResponseDto, 'token'> {}
