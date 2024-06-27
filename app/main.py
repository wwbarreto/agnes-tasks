from fastapi import FastAPI
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse

from app.api.endpoints.healthcheck import router as healthcheck_router

app = FastAPI()

app.include_router(healthcheck_router, prefix="/api", tags=["healthcheck"])
