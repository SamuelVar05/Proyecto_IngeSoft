export interface JwtPayloadDto {
  userId: string;
  iat?: number;
  exp?: number;
}
