library("gam")

branch_markers <- function(cell_x_branch, expression, cutoff=.01){
  # Uses gam method used here: https://www.bioconductor.org/packages/devel/bioc/vignettes/slingshot/inst/doc/slingshot.html#identifying-temporally-expressed-genes
  # Returns a list of branch ids pointing to a ranked vector of gene names (ordered starting with miniumum pvalue) having an Fstat pvalue less than cutoff.  
  # expression: gene x cell matrix, values expression levels. should have hugo gene names
  # cell_x_branch: cell x branch matrix, values pseudotime assignment.
  # cutoff: (0, 1] number. only genes with pvalues less than this number will be included in the gene ranking.

  branch_names <- colnames(cell_x_branch)
  top_genes_list <- list()
  for (branch_id in branch_names){
    # remove
    tmp_pseudotime <- cell_x_branch[branch_id]
    tmp_pseudotime <- tmp_pseudotime[!is.na(tmp_pseudotime)]
    cells_have_values <- names(tmp_pseudotime)
    tmp_expression <- t(expression[,cells_have_values])
    gam.pval <- apply(expression,1,function(z){
      d <- data.frame(z=z, t=t)
      tmp <- gam(z ~ lo(t), data=d)
      p <- summary(tmp)[4][[1]][1,5]
      p
    })
    gene_names <- names(sort(gam.pval[gam.pval< .01]))
    top_genes_list[[branch_id]] <- gene_names
  }
  
  top_genes_list
}

