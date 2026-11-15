"""Admin endpoints. Phase 2: documented stubs that answer 501 until their sprint (see Jira)."""
from fastapi import APIRouter, HTTPException

router = APIRouter(prefix='/admin', tags=['admin'])


@router.post('/products')
def post_1():
    """FR-17 create product"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-17 create product')


@router.patch('/variants/{variant_id}/stock')
def patch_2():
    """FR-18 set stock"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-18 set stock')


@router.patch('/variants/{variant_id}/price')
def patch_3():
    """FR-18 set price"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-18 set price')


@router.get('/orders')
def get_4():
    """FR-19 list orders"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-19 list orders')


@router.patch('/orders/{order_id}/status')
def patch_5():
    """FR-19 change status"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-19 change status')


@router.patch('/users/{user_id}')
def patch_6():
    """FR-20 roles"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-20 roles')


@router.get('/reports/sales')
def get_7():
    """FR-21 sales report"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-21 sales report')


@router.patch('/reviews/{review_id}')
def patch_8():
    """FR-22 moderate review"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-22 moderate review')
