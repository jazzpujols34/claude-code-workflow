#!/bin/bash
# Claude Code Workflow — Shell Automations
#
# ── INSTALLATION ──────────────────────────────────────────────────
#
# 1. Copy this file somewhere permanent:
#      cp scripts/automations-template.sh ~/.claude-automations.sh
#
# 2. Edit PROJECT_ROOT below to point to your project directory.
#
# 3. Add this line to your ~/.zshrc (or ~/.bashrc):
#      source ~/.claude-automations.sh
#
# 4. Reload your shell:
#      source ~/.zshrc
#
# That's it. Now you have: morning, status, evaluate, weekly, handover, learn
# ──────────────────────────────────────────────────────────────────

PROJECT_ROOT="$HOME/projects/your-project"

# ─── Morning Briefing ───────────────────────────────────────────
# Reads DASHBOARD.md and gives you today's priorities
alias morning="cd $PROJECT_ROOT && claude -p 'Read DASHBOARD.md. Give me: 1) Top 3 priorities for today 2) Any blockers to address 3) Quick wins I can ship in <30 min'"

# ─── Quick Status ────────────────────────────────────────────────
# Shows current status of all active projects
alias status="cd $PROJECT_ROOT && claude -p 'Read DASHBOARD.md and show current status of all active projects in a table'"

# ─── Evaluate New Idea ───────────────────────────────────────────
# Runs the should-i-build-this decision framework
# Usage: evaluate "An app that tracks reading habits"
alias evaluate="cd $PROJECT_ROOT && claude -p 'Read .claude/skills/should-i-build-this.md and evaluate this idea:'"

# ─── Weekly Review ───────────────────────────────────────────────
# Summarizes the week across all projects
alias weekly="cd $PROJECT_ROOT && claude -p 'Read DASHBOARD.md and all project status files. Generate weekly summary: 1) Shipped this week 2) Revenue progress 3) Next week priorities'"

# ─── Session Handover ────────────────────────────────────────────
# Write a handover file at end of session
# Usage: handover
alias handover="claude -p 'Write HANDOVER.md summarizing: 1) What was done 2) What is in progress 3) Blockers 4) Exact next steps with file paths'"

# ─── Capture Learning ────────────────────────────────────────────
# After learning something reusable
# Usage: learn "Cloudflare Workers can't use Node.js crypto"
alias learn="cd $PROJECT_ROOT && claude -p 'Add a new knowledge file to .claude/knowledge/ documenting what we learned about:'"

# ─── Security Audit ──────────────────────────────────────────────
# Run the security audit checklist on a project
# Usage: audit "my-project"
alias audit="cd $PROJECT_ROOT && claude -p 'Read .claude/pm-handbook.md Chapter 9. Run a security audit on:'"
