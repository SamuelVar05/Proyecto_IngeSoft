import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { Category } from './category.entity';

@Entity()
export class Product {
  @PrimaryGeneratedColumn('increment')
  id: string;

  @Column({ unique: true })
  name: string;

  @Column({
    type: 'float',
  })
  price: number;

  @Column({
    nullable: true,
  })
  barcode: string;

  

  @ManyToOne(() => Category, (category) => category.products)
  category: Category;
}
