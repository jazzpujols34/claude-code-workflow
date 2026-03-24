---
name: mvp-launch-checklist
description: Use before launching any product or feature to production. Checks infrastructure, performance, UX, and code quality. Trigger on "launch checklist", "ready to launch", "pre-launch".
---

# Skill: MVP Launch Checklist

> Run through this before launching any product.
> Usage: `Read .claude/skills/mvp-launch-checklist.md and audit [project name]`

## Pre-Launch Checklist

### Infrastructure (Must Have)
- [ ] **Auth**: Using a managed service (Clerk, Supabase Auth, etc.) — NOT custom auth
- [ ] **Payments**: Stripe, ECPay, or equivalent — NOT custom payment system
- [ ] **Error Tracking**: Sentry or equivalent configured and tested
- [ ] **Analytics**: GA4, PostHog, or Plausible set up
- [ ] **Environment**: All secrets in .env, never hardcoded
- [ ] **Deploy**: One-click deploy working (Vercel, Cloudflare, Render)

### Performance (Must Check)
- [ ] **Lighthouse Score**: 70+ on all metrics
- [ ] **Mobile**: Tested on actual phone, not just responsive mode
- [ ] **Loading States**: No blank screens while data loads
- [ ] **Error States**: Graceful handling when things break

### UX (Often Missed)
- [ ] **Onboarding**: First-time user knows exactly what to do
- [ ] **Empty States**: Blank pages explain what goes there
- [ ] **5-Second Test**: Can someone understand the product in 5 seconds?

### Code Quality (Sanity Check)
- [ ] **No console.logs**: Removed from production
- [ ] **README**: Someone else can run the project
- [ ] **Types**: No `any` types without justification

### Launch Readiness
- [ ] **One User Test**: Have ONE real person (not you) try it
- [ ] **Payment Test**: Actually pay yourself through the full flow
- [ ] **Mobile Test**: Use the product on your phone for 5 minutes
- [ ] **Share URL**: OG image, title, description look correct

## The Rule

> "Shipped and imperfect beats polished and never launched."

If you've checked the Must Have items, SHIP. The rest can be iterated.

## Post-Launch (First 48 Hours)

- [ ] Monitor error tracking for crashes
- [ ] Check analytics for user flow
- [ ] Get feedback from 3 real users
- [ ] Fix critical bugs immediately
- [ ] Ignore feature requests (for now)

## Gotchas

- **Lighthouse on localhost lies.** Always test the deployed URL, not `localhost`. Cloudflare/Vercel add middleware that changes perf characteristics.
- **"Tested on phone" means your actual phone.** Chrome DevTools responsive mode doesn't simulate real touch, real keyboard popups, or real network conditions.
- **OG images break silently.** Test with Twitter Card Validator and Facebook Debugger — don't assume the meta tags work because they look right in the HTML.
- **First user test: don't coach them.** Hand them the URL and watch. If you have to explain how to start, the onboarding is broken.
