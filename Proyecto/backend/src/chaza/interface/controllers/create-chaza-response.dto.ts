export interface CreateChazaResponseDto {
  chaza: {
    // id: string;
    nombre: string;
    descripcion: string;
    ubicacion: string;
    foto_id?: number;
    id_usuario: string;
  };
}
