import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty, IsString, Min, MinLength } from 'class-validator';

export class LoginUserDto {
  @ApiProperty({
    example: 'juan.medina@gmail.com',
  })
  @IsEmail()
  email: string;
  @ApiProperty({
    example: 'password123',
  })
  @IsNotEmpty()
  @IsString({
    message: 'Password must be a string',
  })
  @MinLength(6) 
  password: string;
}
