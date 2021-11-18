report.pdf: report.Rmd ./code/propensity_score.R
	R -e "require(rmarkdown); render('report.Rmd')"

./code/propensity_score.R: ./data/abortion_data.csv
	cd code; R CMD BATCH --vanilla propensity_score.R

clean:
	rm -f *.html *.pdf *.tex *.aux *.log *.docx *.Rout ./code/*.Rout
