import { Entity, PrimaryGeneratedColumn, Column, ManyToOne } from 'typeorm';
import { User } from 'src/user/domain/entities/user.entity';

@Entity()
export class Chaza {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ManyToOne(() => User)
  id_usuario: User;

  @Column({ nullable: true })
  nombre: string;

  @Column({ nullable: true })
  descripcion: string;

  @Column({ nullable: true })
  ubicacion: string;

  @Column({ nullable: true })
  foto_id: number;
}
