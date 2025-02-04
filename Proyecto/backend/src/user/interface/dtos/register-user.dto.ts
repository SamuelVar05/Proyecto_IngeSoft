import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty, IsString, Min, MinLength } from 'class-validator';

export class RegisterUserDto {
  @ApiProperty()
  @IsNotEmpty()
  @IsEmail()
  email: string;
  @IsNotEmpty()
  @IsString({
    message: 'Password must be a string',
  })
  @MinLength(6)
  @ApiProperty()
  password: string;
}
