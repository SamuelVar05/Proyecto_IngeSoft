import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';

import { Chaza } from 'src/chaza/domain/entities/chaza.entity';
import { Category } from 'src/category/domain/entites/category.entity';

@Entity()
export class Product {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  name: string;

  @Column({
    type: 'float',
  })
  price: number;

  @Column({
    nullable: true,
  })
  barcode?: string;

  @Column()
  description: string;

  @ManyToOne(() => Chaza, (chaza) => chaza.products)
  chaza: Chaza;

  @ManyToOne(() => Category, (category) => category.products)
  category: Category;
}
