# Knowledge: Payment Integration

> Patterns for integrating payment providers into web apps.
> Read this before: adding payments, setting up webhooks, or choosing a payment provider.

## Context

Payment integration is one of the most common "should NOT build from scratch" areas. Use a provider. But even with providers, there are sharp edges — especially around webhooks, idempotency, and test-vs-production switching.

## The Pattern

### Provider Selection

| Provider | Best For | Fees | Setup Time |
|----------|----------|------|------------|
| **Stripe** | International, SaaS | 2.9% + $0.30 | Instant (test), days (live) |
| **ECPay** | Taiwan B2C | 2.75% credit | 1-2 weeks |
| **Paddle** | SaaS (handles tax) | 5% + $0.50 | Days |
| **LemonSqueezy** | Digital products | 5% + $0.50 | Instant |

**Rule of thumb:** Stripe for most things. Local providers for local payment methods.

### What Works

**1. Webhook-First Architecture**

```
User clicks "Pay" → Redirect to provider → Provider processes →
Provider calls YOUR webhook → You credit the account

Never credit on redirect return. Users can close the tab.
```

**2. Idempotent Webhooks**

```python
# Always check if already processed
existing = db.get_order(merchant_trade_no)
if existing and existing.status == "paid":
    return "1|OK"  # Already handled — return success

# Process payment...
db.update_order(merchant_trade_no, status="paid")
```

**3. Signature Verification**

```python
# ALWAYS verify webhook signatures before processing
# Never trust unverified webhook data
expected_sig = compute_signature(payload, secret)
if not hmac.compare_digest(received_sig, expected_sig):
    raise ValueError("Invalid signature")
```

### What Doesn't Work

```python
# Crediting on redirect (user can close tab before redirect)
@app.get("/payment-success")
def success():
    add_credits(user)  # BAD — webhook hasn't confirmed yet

# Trusting client-side payment confirmation
# BAD — anyone can POST fake success data

# Using test credentials in production (or vice versa)
# Always use environment variables, never hardcode
```

### Why

Payment providers are asynchronous. The user's browser and the payment confirmation are two separate flows. The webhook is the source of truth — the redirect is just UX.

## Gotchas

- **Test vs Production credentials:** Use env vars. Double-check before launch. One wrong credential = payments silently failing.
- **Webhook retry:** Providers retry failed webhooks. Your handler MUST be idempotent.
- **Currency handling:** Always store amounts in smallest unit (cents, not dollars). Floating point math will bite you.
- **PCI compliance:** Never handle raw card numbers. Always use the provider's hosted checkout or tokenization.
- **Refunds:** Build the refund flow BEFORE launch. You will need it.

## Minimal Integration Checklist

- [ ] Environment variables for API keys (test + production)
- [ ] Checkout endpoint that redirects to provider
- [ ] Webhook endpoint with signature verification
- [ ] Idempotent order processing
- [ ] Success/failure redirect pages for user
- [ ] Error logging for failed payments
- [ ] Test end-to-end in sandbox before going live

## References

- [Stripe Webhooks Best Practices](https://stripe.com/docs/webhooks/best-practices)
- [Stripe Checkout Quickstart](https://stripe.com/docs/checkout/quickstart)
