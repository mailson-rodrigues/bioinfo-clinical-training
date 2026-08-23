# Projeto de Estudo — Bioinformática Clínica

## Ambiente
- Sistema: Windows 11 + WSL2 (Ubuntu 22.04), rodando no HD externo (D:)
- Conda env: bioinfo (Python 3.10)
- Ferramentas instaladas: fastqc, multiqc, fastp, bwa, samtools, bcftools, gatk4, vcftools, tabix, bedtools, sra-tools, igv

## Dados utilizados
- Amostra: NA12878 (SRR062634) — Genome in a Bottle, subset de 50.000 reads
- Referência: chr21, GRCh38 (UCSC)
- VCF de exemplo: dbSNP (00-common_all.vcf.gz) — 37.302.978 variantes catalogadas

## Log de progresso
- [21/08/2026] Módulo 1 concluído:
  - Setup de ambiente reconfigurado do zero (WSL2 movido para HD externo por limitação de espaço em disco)
  - Ferramentas de bioinformática instaladas via conda/mamba
  - Formatos FASTA/FASTQ/VCF explorados e compreendidos
  - Primeiro FastQC rodado: identificada queda de qualidade nas posições 90-100 da read (padrão normal Illumina) — será tratado com trimming no Módulo 2
  - Primeiro script Python de automação (contagem de reads)
  - IGV instalado e testado com sucesso (após resolver conflito de porta e renderização gráfica via WSLg), genoma chr21 carregado e navegação testada

## Dúvidas/observações
- Resolvido: IGV não abria devido a processo travado ocupando a porta de controle — resolvido com `pkill -9 -f igv` e `wsl --update`

Optamos pela estratégia de corte por qualidade (--cut_tail) em vez de descarte de reads inteiras, pois preservou mais dados (99.152 vs 92.180 reads) com qualidade superior (Q20: 98.4% vs 95.8%). O alerta de GC content na v2 foi investigado e atribuído à variação de comprimento pós-corte, não a contaminação — decisão documentada e aceita.

## Módulo 2 — Controle de Qualidade (concluído em 21/08/2026)

### O que foi feito
- Trimming com fastp testado em duas estratégias:
  - v1: descarte de reads de baixa qualidade (padrão) — 92.180/100.000 reads aprovadas
  - v2: corte de extremidade (`--cut_tail`, janela 4, Q20) — 99.152/100.000 reads aprovadas
- FastQC rodado nos dados brutos e em ambas as versões trimmed
- Relatórios consolidados com MultiQC

### Decisão tomada e justificativa
Optamos pela estratégia v2 (`--cut_tail`) para os próximos módulos, pois:
- Preservou mais dados (99.152 vs 92.180 reads)
- Melhorou a qualidade de forma mais consistente (Q20: 98,4% vs 95,8%)
- Resolveu o alerta de "Per base sequence quality" que estava vermelho nos dados brutos

### Trade-off aceito
- A v2 introduziu um alerta amarelo em "Per sequence GC content", causado pela variação de comprimento das reads pós-corte (não uniformes como na v1)
- Avaliado como efeito estatístico esperado, não indicativo de contaminação real — decisão documentada e aceita

### Arquivos gerados
- `results/trimmed/SRR062634_{1,2}_trimmed_v2.fastq` — dados finais a serem usados no Módulo 3 (alinhamento)
- `results/multiqc_report/multiqc_report.html` — relatório consolidado

### Próximos passos
- Módulo 3: alinhar `SRR062634_{1,2}_trimmed_v2.fastq` contra `chr21.fa` com BWA-MEM
## Módulo 3 — Alinhamento e Processamento de BAM (em andamento, 23/08/2026)

### O que foi feito
- Alinhamento com BWA-MEM: reads filtradas (v2) contra referência chr21
- Conversão SAM → BAM, ordenação por posição, indexação

### Nota metodológica importante
A taxa de mapeamento geral ficou em 27,62% — valor esperado e não indicativo de problema de qualidade.

**Motivo:** a amostra SRR062634 (NA12878) é sequenciamento de genoma completo, mas a
referência utilizada neste treinamento é apenas o chr21 (escolha deliberada para
manter os exercícios leves). Como o chr21 representa ~1,5-2% do genoma humano total,
é matematicamente esperado que a grande maioria das reads (vindas de outros
cromossomos) não encontre onde mapear nessa referência parcial.

**Validação:** das reads que efetivamente mapearam no chr21, 60,7% estão "properly
paired" (pareadas corretamente) — consistente com dados de boa qualidade, confirmando
que a baixa taxa geral é um artefato da referência parcial, não da qualidade do
sequenciamento ou do processo de alinhamento.

**Em um pipeline de produção real:** a referência seria o genoma completo (todos os
cromossomos), e a taxa de mapeamento esperada seria >95%.

### Arquivos gerados
- `results/aligned/SRR062634.sorted.bam` (+ `.bai`) — BAM ordenado e indexado, pronto
  para chamada de variantes no Módulo 4
