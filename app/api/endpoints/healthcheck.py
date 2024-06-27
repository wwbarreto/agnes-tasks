from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.sql import text
from app.api.deps import get_db

router = APIRouter()

@router.get("/healthcheck", status_code=200)
async def healthcheck(db: AsyncSession = Depends(get_db)):
  try:
    await db.execute(text("SELECT 1"))
    return {"status": "healthy"}

  except SQLAlchemyError as error:
    return {"status": "unhealthy", "message": str(error)}, 500
  
  except Exception as error:
    return {"status": "unhealthy", "message": str(error)}, 500
