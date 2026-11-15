"""Orders endpoints. Phase 2: documented stubs that answer 501 until their sprint (see Jira)."""
from fastapi import APIRouter, HTTPException

router = APIRouter(prefix='', tags=['orders'])


@router.post('/orders')
def post_1():
    """FR-10/FR-11 place order"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-10/FR-11 place order')


@router.get('/orders/track')
def get_2():
    """FR-12 track order"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-12 track order')


@router.get('/me/orders')
def get_3():
    """FR-13 order history"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-13 order history')
