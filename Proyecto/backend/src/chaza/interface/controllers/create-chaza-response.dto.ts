export interface CreateChazaResponseDto {
  chaza: {
    chazaId: string;
    nombre: string;
    descripcion: string;
    ubicacion: string;
    foto_id?: number;
    id_usuario: string;
  };
}
