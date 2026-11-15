"""Cart endpoints. Phase 2: documented stubs that answer 501 until their sprint (see Jira)."""
from fastapi import APIRouter, HTTPException

router = APIRouter(prefix='', tags=['cart'])


@router.get('/cart')
def get_1():
    """FR-08 saved cart"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-08 saved cart')


@router.post('/cart/items')
def post_2():
    """FR-08 add item"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-08 add item')


@router.patch('/cart/items/{variant_id}')
def patch_3():
    """FR-08 change quantity"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-08 change quantity')


@router.delete('/cart/items/{variant_id}')
def delete_4():
    """FR-08 remove item"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-08 remove item')


@router.get('/wishlist')
def get_5():
    """FR-09 wishlist"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-09 wishlist')
