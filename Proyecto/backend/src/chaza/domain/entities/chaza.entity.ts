import { Entity, PrimaryGeneratedColumn, Column, ManyToOne } from 'typeorm';
import { User } from 'src/user/domain/entities/user.entity';

@Entity()
export class Chaza {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ManyToOne(() => User)
  id_usuario: User;

  @Column()
  nombre: string;

  @Column()
  descripcion: string;

  @Column()
  ubicacion: string;

  @Column({ nullable: true })
  foto_id: number | undefined;
}
