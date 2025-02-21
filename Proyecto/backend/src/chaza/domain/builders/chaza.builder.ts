import { Chaza } from '../entities/chaza.entity';
import { User } from 'src/user/domain/entities/user.entity';

export class ChazaBuilder {
  private chaza: Chaza;

  constructor() {
    this.chaza = new Chaza();
  }

  setNombre(nombre: string): ChazaBuilder {
    this.chaza.nombre = nombre;
    return this;
  }

  setDescripcion(descripcion: string): ChazaBuilder {
    this.chaza.descripcion = descripcion;
    return this;
  }

  setUbicacion(ubicacion: string): ChazaBuilder {
    this.chaza.ubicacion = ubicacion;
    return this;
  }

  setFotoId(foto_id: number | undefined): ChazaBuilder {
    this.chaza.foto_id = foto_id || undefined;
    return this;
  }

  setUsuario(usuario: string): ChazaBuilder {
    this.chaza.id_usuario = usuario;
    return this;
  }

  build(): Chaza {
    return this.chaza;
  }
}
