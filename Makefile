report.pdf: report.Rmd ./data/*
	R -e "require(rmarkdown); render('report.Rmd')"

./data/doubly_robust.Rda: ./data/abortion_data.csv ./code/propensity_score.R
	cd code; R CMD BATCH --vanilla propensity_score.R

clean:
	rm -f *.html *.pdf *.tex *.aux *.log *.docx *.Rout ./code/*.Rout
