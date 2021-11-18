report.pdf: report.Rmd ./data/*
	R -e "require(rmarkdown); render('report.Rmd')"

./data/doubly_robust.Rda: ./data/cleaned_data.Rda ./code/01_doubly_robust.R
	cd code; R CMD BATCH --vanilla 01_doubly_robust.R

./data/cleaned_data.Rda: ./data/abortion_data.csv ./code/00_clean_data.R
	cd code; R CMD BATCH --vanilla 00_clean_data.R

clean:
	rm -f *.html *.pdf *.tex *.aux *.log *.docx *.Rout ./code/*.Rout
