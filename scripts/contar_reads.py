import sys
from pathlib import Path

def contar_reads_fastq(caminho_arquivo):
    """Conta o número de reads em um arquivo FASTQ."""
    with open(caminho_arquivo) as f:
        linhas = sum(1 for _ in f)
    return linhas // 4

if __name__ == "__main__":
    arquivo = sys.argv[1]
    total = contar_reads_fastq(arquivo)
    print(f"Arquivo: {arquivo}")
    print(f"Total de reads: {total:,}")
