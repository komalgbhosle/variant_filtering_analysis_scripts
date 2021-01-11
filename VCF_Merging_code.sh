#$ cd [Working directory path]

#Step 1: Separate based on control and disease (run this script seperately for control and disease)
#Step 2: Index and zip vcf files for merging
echo "Indexing vcf"
for g in *.vcf; do bgzip $g && tabix -p vcf $g.gz; done
echo "Done with indexing"

#Step 3: Merging vcf files 
echo "Merging vcf"
bcftools merge *.vcf.gz -Oz > Merged.vcf.gz
echo "Done Merging vcf"

#Step 4: unzippinf Merged VCF
echo "unzipe merged vcf"
gzip -d Merged.vcf.gz
echo "Done with Unzipping"

#step 5: Remove header (easy to handle) # note firstly change #CHROM to CHROM
echo "VCF filtering"
sed "s/#CHROM/CHROM/" Merged.vcf | sed "/^#/d" > Asthma_Merged.vcf    #( remove lines starting with)
echo "Done with VCF filtering"
