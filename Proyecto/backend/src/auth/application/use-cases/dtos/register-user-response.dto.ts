export interface RegisterUserResponseDto {
  user: {
    userid: string;
    email: string;
  };
  token: string;
}
