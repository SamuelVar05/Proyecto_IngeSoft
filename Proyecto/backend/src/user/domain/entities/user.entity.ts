import { Chaza } from 'src/chaza/domain/entities/chaza.entity';
import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  OneToMany,
} from 'typeorm';

enum Role {
  ADMIN = 'admin',
  USER = 'user',
  SELLER = 'seller',
}

@Entity()
export class User {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ unique: true })
  email: string;

  @Column()
  password: string;

  @Column({
    type: 'enum',
    enum: Role,
    default: Role.USER,
  })
  role: Role;

  @CreateDateColumn()
  createdAt: Date;

  @OneToMany(() => Chaza, (chaza) => chaza.id_usuario)
  chazas: Chaza[];
}
