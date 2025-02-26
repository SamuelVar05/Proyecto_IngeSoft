import { Category } from '../entites/category.entity';

export class CategoryBuilder {
  private category: Category;
  constructor() {
    this.category = new Category();
  }

  setName(name: string): CategoryBuilder {
    this.category.name = name;
    return this;
  }
  setDescription(description: string): CategoryBuilder {
    this.category.description = description;
    return this;
  }
  build(): Category {
    return this.category;
  }
}
