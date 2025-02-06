declare namespace NodeJS {
  interface ProcessEnv {
    PORT: string;
    DB_HOST: string;
    DB_PORT: string;
    DB_USER: string;
    DB_PASSWORD: string;
    DB_NAME: string;
    SECRET_KEY: string;
    SUPABASE_URL: string;
    SUPABASE_KEY: string;
    SUPABASE_BUCKET_NAME: string;
  }
}
