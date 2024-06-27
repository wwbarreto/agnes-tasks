from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.orm import sessionmaker
from os import environ

db_name = environ.get('POSTGRES_DB')
db_user = environ.get('POSTGRES_USER')
db_pass = environ.get('POSTGRES_PASSWORD')
db_host = environ.get('POSTGRES_HOST')

DATABASE_URI = f"postgresql+asyncpg://{db_user}:{db_pass}@{db_host}:5432/{db_name}"

engine = create_async_engine(DATABASE_URI, echo=True)

async_session = sessionmaker(
  bind=engine, 
  class_=AsyncSession,
  expire_on_commit=False
)

