import { IsEmail, IsNotEmpty, IsString, Min, MinLength } from 'class-validator';

export class RegisterUserDto {
  @IsEmail()
  email: string;
  @IsNotEmpty()
  @IsString({
    message: 'Password must be a string',
  })
  @MinLength(6)
  password: string;
}
