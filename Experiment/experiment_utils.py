import os
import csv
from typing import List, Dict
from collections import Counter

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
        "precision-2", "recall-2", "ROUGE-2"
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