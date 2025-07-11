import csv
from typing import List, Dict


def save_results_to_csv(results: List[Dict[str, str]], filepath: str) -> None:
    """Save experiment results to a CSV file.

    Parameters
    ----------
    results:
        List of dictionaries containing question_id, question_string,
        answer_llm and answer_gold.
    filepath:
        Destination path for the CSV file.
    """
    if not results:
        return

    fieldnames = ["question_id", "question_string", "answer_llm", "answer_gold"]
    with open(filepath, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        for row in results:
            writer.writerow({k: row.get(k, "") for k in fieldnames})
