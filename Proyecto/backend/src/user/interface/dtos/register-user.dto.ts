import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty, IsString, Min, MinLength } from 'class-validator';

export class RegisterUserDto {
  @ApiProperty({
    example: 'juan.medina@gmail.com',
  })
  @IsNotEmpty()
  @IsEmail()
  email: string;
  @IsNotEmpty()
  @IsString({
    message: 'Password must be a string',
  })
  @MinLength(6)
  @ApiProperty({
    example: 'password123',
  })
  password: string;
}
