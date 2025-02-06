import { SetMetadata } from '@nestjs/common';
import { ROLES_KEY } from 'src/constants/key-decorator';
import { ROLES } from 'src/constants/ROLES';

export const Roles = (...roles: Array<keyof typeof ROLES>) =>
  SetMetadata(ROLES_KEY, roles);
