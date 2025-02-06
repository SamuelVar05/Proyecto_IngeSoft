import { User } from '../entities/user.entity';

export class UserBuilder {
  private user: User;

  constructor() {
    this.user = new User();
  }

  setEmail(email: string): UserBuilder {
    this.user.email = email;
    return this;
  }

  setPassword(password: string): UserBuilder {
    this.user.password = password;
    return this;
  }

  build(): User {
    return this.user;
  }
}
