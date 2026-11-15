"""Muscle Mania REST API (SRS section 9). Routers are stubs in Phase 2; each one lists the requirements it will implement."""
from fastapi import FastAPI
from .routers import admin, auth, cart, orders, products

app = FastAPI(title='Muscle Mania Store API', version='0.1.0', docs_url='/docs')
for r in (auth.router, products.router, cart.router, orders.router, admin.router):
    app.include_router(r, prefix='/api/v1')


@app.get('/api/v1/health')
def health():
    return {'status': 'ok'}
