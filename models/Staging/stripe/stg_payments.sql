select
        id as payment,
        ORDER_ID as order_id,
        PAYMENT_METHOD as payment_method,
        STATUS,
        AMOUNT/100 as amount,
        CREATED as created_at,
from raw.stripe.payment