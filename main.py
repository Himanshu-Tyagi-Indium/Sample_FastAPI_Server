from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello from FastAPI with uv!"}

@app.get("/healthz")
def health_check():
    return {"status": "ok"}
