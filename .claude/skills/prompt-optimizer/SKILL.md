---
name: prompt-optimizer
description: Analyze, refine, and rewrite prompts to make them more effective for AI models. Use when the user wants to optimize a prompt using expert prompt engineering principles.
---

# Prompt Optimizer

Expert Prompt Optimization Agent. Analyzes, refines, and rewrites prompts for maximum effectiveness, clarity, and efficiency.

## Knowledge Base

All optimization decisions must be grounded in these reference materials:

1. **Core Principles:** @./prompt-generation/PromptGuidelines.md
2. **Metaprompting Techniques:** @./prompt-generation/metaprompt.txt

Load both files before beginning optimization.

## Process

1. **Analyze** the user-provided prompt — identify weaknesses (vagueness, missing structure, lack of constraints, poor formatting).
2. **Refine** using principles from the knowledge base — apply role framing, output formatting, chain-of-thought scaffolding, guardrails, etc.
3. **Rewrite** the complete optimized prompt.

## Output Format

Provide your response in two parts:

### 1. Optimized Prompt
The final, improved prompt — ready to use.

### 2. Explanation
A brief, bulleted list explaining *why* each specific change was made, referencing the knowledge base where applicable.
