import os
import csv
from typing import List, Dict
from collections import Counter
import re
import json

# === ROUGE-N metric functions ===
def get_ngrams(text: str, n: int) -> Counter:
    """Return a Counter of n-grams from whitespace-tokenized text."""
    tokens = text.split()
    return Counter(tuple(tokens[i : i + n]) for i in range(len(tokens) - n + 1))


def precision_n(pred: str, gold: str, n: int) -> float:
    """Compute precision for n-grams: overlap_count / total_predicted_ngrams."""
    pred_ngrams = get_ngrams(pred, n)
    gold_ngrams = get_ngrams(gold, n)
    overlap = sum((pred_ngrams & gold_ngrams).values())
    total_pred = sum(pred_ngrams.values())
    return overlap / total_pred if total_pred > 0 else 0.0


def recall_n(pred: str, gold: str, n: int) -> float:
    """Compute recall for n-grams: overlap_count / total_reference_ngrams."""
    pred_ngrams = get_ngrams(pred, n)
    gold_ngrams = get_ngrams(gold, n)
    overlap = sum((pred_ngrams & gold_ngrams).values())
    total_gold = sum(gold_ngrams.values())
    return overlap / total_gold if total_gold > 0 else 0.0


def f1_n(prec: float, rec: float) -> float:
    """Compute the F1 score given precision and recall."""
    return (2 * prec * rec / (prec + rec)) if (prec + rec) > 0 else 0.0


def load_processed_ids(filepath: str) -> set:
    """Return the set of question_id already in filepath (if it exists)."""
    if not os.path.exists(filepath):
        return set()
    with open(filepath, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        return {row["question_id"] for row in reader}


def append_result_to_csv(row: Dict[str, str], filepath: str) -> None:
    """Append a single result row to filepath, creating and headering if needed."""
    # Static headers including metrics
    fieldnames = [
        "question_id", "question_string", "answer_llm", "answer_gold",
        "precision-1", "recall-1", "ROUGE-1",
        "precision-2", "recall-2", "ROUGE-2",
        "factual_correctness", "completeness", "relevance", "justification", "depth",
        "overall_score", "pass"
    ]

    file_exists = os.path.exists(filepath)
    if filepath and os.path.dirname(filepath):
        os.makedirs(os.path.dirname(filepath), exist_ok=True)

    # Always open in append mode (creates file if missing)
    with open(filepath, "a", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        if not file_exists:
            writer.writeheader()
        # Ensure row only has expected keys
        filtered = {key: row.get(key, "") for key in fieldnames}
        writer.writerow(filtered)

def parse_judge_response(raw: str) -> dict:
    """
    Extrahiert den JSON-Teil aus dem rohen LLM-Output und lädt ihn als dict.
    - Sucht zuerst nach einem ```json …```-Block
    - Fällt andernfalls auf manuellen Brace-Matching-Algorithmus zurück
    - Bei JSONDecodeError wird der Extrakt ausgegeben für Debugging
    """
    # 1. Versuch: ```json … ```-Block
    fence_pattern = r"```json\s*([\s\S]+?)\s*```"
    m = re.search(fence_pattern, raw)
    if m:
        json_str = m.group(1)
    else:
        # 2. Fallback: finde ersten '{' und matchende '}' per Stack-Zählung
        start = raw.find('{')
        if start == -1:
            raise ValueError("Keine JSON-Struktur gefunden")
        level = 0
        end = None
        for idx, ch in enumerate(raw[start:], start):
            if ch == '{':
                level += 1
            elif ch == '}':
                level -= 1
                if level == 0:
                    end = idx + 1
                    break
        if end:
            json_str = raw[start:end]
        else:
            # falls kein schließendes '}' gefunden wird, nimm alles ab start
            json_str = raw[start:]
    
    # 3. Versuch des Parsens mit Debug-Ausgabe im Fehlerfall
    try:
        return json.loads(json_str)
    except json.JSONDecodeError as e:
        # Debug: zeige den problematischen Teil
        print("=== Extracted JSON string (for debugging) ===")
        print(json_str)
        print("=== End of extracted JSON ===")
        raise
