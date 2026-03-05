#!/bin/bash
# Claude Code Workflow — Shell Automations
#
# Add these aliases to your ~/.zshrc or ~/.bashrc
# Then run: source ~/.zshrc
#
# Customize PROJECT_ROOT to point to your project directory.

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
