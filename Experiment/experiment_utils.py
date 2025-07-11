import os
import csv
from typing import List, Dict


def save_results_to_csv(results: List[Dict[str, str]], filepath: str) -> None:
    """Save experiment results to a CSV file, creating parent dirs if needed,
    and always truncating (overwriting) any existing file."""
    if not results:
        return

    # Ensure target directory exists
    directory = os.path.dirname(filepath)
    if directory:
        os.makedirs(directory, exist_ok=True)

    fieldnames = ["question_id", "question_string", "answer_llm", "answer_gold"]
    with open(filepath, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        for row in results:
            writer.writerow({k: row.get(k, "") for k in fieldnames})

GROUND_TRUTH_CSV = "results_ground_truth.csv"

def load_processed_ids(filepath: str) -> set:
    """Return the set of question_id already in filepath (if it exists)."""
    if not os.path.exists(filepath):
        return set()
    with open(filepath, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        return {row["question_id"] for row in reader}


def append_result_to_csv(row: Dict[str, str], filepath: str) -> None:
    """Append a single result row to filepath, creating and headering if needed."""
    fieldnames = ["question_id", "question_string", "answer_llm", "answer_gold"]
    # Add dynamic metrics keys
    n = row.get("n", 2)
    fieldnames += [f"precision-{n}", f"recall-{n}", f"ROUGE-{n}"]

    file_exists = os.path.exists(filepath)
    directory = os.path.dirname(filepath)
    if directory:
        os.makedirs(directory, exist_ok=True)

    with open(filepath, "a", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        if not file_exists:
            writer.writeheader()
        writer.writerow(row)