# Bioinformática Clínica — Jornada de Aprendizado

Projeto de estudo prático e documentado, construído para unir minha formação em **Biomedicina, Genética e Genômica** com **Inteligência Artificial e Machine Learning**, com foco em **análise de NGS e triagem de variantes clínicas para diagnóstico**.

Cada módulo documenta não apenas os comandos executados, mas o **raciocínio por trás de cada decisão técnica** — incluindo trade-offs, troubleshooting real de ambiente, e justificativas alinhadas a boas práticas de reprodutibilidade exigidas em contexto clínico.

## Sobre mim

Biomédico com anos de experiência laboratorial e especialização em Genética e Genômica, atualmente cursando Tecnologia em Inteligência Artificial e Machine Learning. Este repositório documenta minha transição para bioinformática clínica, combinando conhecimento biológico sólido com competência técnica em análise de dados genômicos.

**Contato:** [LinkedIn](https://www.linkedin.com/in/mailson-rodrigues/) · biomedico.mailson@gmail.com

## Estrutura do treinamento

O aprendizado está organizado em 7 módulos progressivos, cobrindo o pipeline completo de análise de NGS para diagnóstico:

| Módulo | Tema | Status |
|---|---|---|
| 1 | Fundamentos e setup do ambiente (WSL2, conda, formatos FASTA/FASTQ/VCF) | ✅ Concluído |
| 2 | Controle de qualidade (FastQC, fastp, MultiQC, trimming) | ✅ Concluído |
| 3 | Alinhamento e processamento de BAM (BWA-MEM, SAMtools, BQSR) | 🔄 Em andamento |
| 4 | Chamada de variantes (GATK HaplotypeCaller, DeepVariant) | ⬜ Planejado |
| 5 | Anotação de variantes (VEP, ClinVar, gnomAD) | ⬜ Planejado |
| 6 | Classificação ACMG/AMP de patogenicidade | ⬜ Planejado |
| 7 | Casos clínicos integrados — pipeline completo (FASTQ → laudo) | ⬜ Planejado |

## Destaques metodológicos

- **Decisões documentadas com justificativa técnica** — por exemplo, comparação entre estratégias de trimming (descarte de reads vs. corte de extremidade), com análise quantitativa de trade-offs
- **Dados de referência públicos e reconhecidos** — amostra NA12878 (Genome in a Bottle), genoma de referência GRCh38
- **Boas práticas de reprodutibilidade** — ambiente conda isolado, versionamento contínuo, logs de decisão em cada etapa
- **Consciência regulatória** — considerações sobre habilitação profissional (CFBM) e implicações da ANVISA para software como dispositivo médico (SaMD) aplicadas ao contexto de triagem clínica

## Stack técnica

`Python` · `WSL2/Linux` · `Conda/Mamba` · `FastQC` · `fastp` · `MultiQC` · `BWA` · `SAMtools` · `BCFtools` · `GATK4` · `IGV` · `Git`

## Estrutura de pastas

```
bioinfo_estudo/
├── raw_data/     # dados brutos (não versionados — ver .gitignore)
├── reference/    # genoma de referência e índices
├── scripts/      # scripts de automação
├── results/      # relatórios de QC, alinhamento, etc.
└── docs/         # documentação detalhada e log de progresso por módulo
```

A documentação detalhada de cada módulo, com o passo a passo completo e as decisões tomadas, está em [`docs/README.md`](docs/README.md).

---

*Repositório em construção ativa — atualizado continuamente conforme o treinamento avança.*
