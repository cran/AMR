# ==================================================================== #
# TITLE                                                                #
# Antimicrobial Resistance (AMR) Data Analysis for R                   #
#                                                                      #
# SOURCE                                                               #
# https://github.com/msberends/AMR                                     #
#                                                                      #
# LICENCE                                                              #
# (c) 2018-2021 Berends MS, Luz CF et al.                              #
# Developed at the University of Groningen, the Netherlands, in        #
# collaboration with non-profit organisations Certe Medical            #
# Diagnostics & Advice, and University Medical Center Groningen.       # 
#                                                                      #
# This R package is free software; you can freely use and distribute   #
# it for both personal and commercial purposes under the terms of the  #
# GNU General Public License version 2.0 (GNU GPL-2), as published by  #
# the Free Software Foundation.                                        #
# We created this package for both routine data analysis and academic  #
# research and it was publicly released in the hope that it will be    #
# useful, but it comes WITHOUT ANY WARRANTY OR LIABILITY.              #
#                                                                      #
# Visit our website for the full manual and a complete tutorial about  #
# how to conduct AMR data analysis: https://msberends.github.io/AMR/   #
# ==================================================================== #

expect_identical(suppressWarnings(p_symbol(c(0.001, 0.01, 0.05, 0.1, 1, NA, 3))),
                 c("***", "**", "*", ".", " ", NA, NA))

expect_warning(key_antibiotics(example_isolates))
expect_identical(suppressWarnings(key_antibiotics(example_isolates)),
                 key_antimicrobials(example_isolates, antifungal = NULL))

expect_warning(key_antibiotics_equal("S", "S"))
expect_identical(suppressWarnings(key_antibiotics_equal("S", "S")),
                 antimicrobials_equal("S", "S", type = "keyantimicrobials"))

expect_warning(filter_first_weighted_isolate(example_isolates))
expect_identical(suppressWarnings(filter_first_weighted_isolate(example_isolates)),
                 filter_first_isolate(example_isolates))

expect_warning(filter_ab_class(example_isolates, "mycobact"))
expect_warning(filter_aminoglycosides(example_isolates))
expect_warning(filter_betalactams(example_isolates))
expect_warning(filter_carbapenems(example_isolates))
expect_warning(filter_cephalosporins(example_isolates))
expect_warning(filter_1st_cephalosporins(example_isolates))
expect_warning(filter_2nd_cephalosporins(example_isolates))
expect_warning(filter_3rd_cephalosporins(example_isolates))
expect_warning(filter_4th_cephalosporins(example_isolates))
expect_warning(filter_5th_cephalosporins(example_isolates))
expect_warning(filter_fluoroquinolones(example_isolates))
expect_warning(filter_glycopeptides(example_isolates))
expect_warning(filter_macrolides(example_isolates))
expect_warning(filter_oxazolidinones(example_isolates))
expect_warning(filter_penicillins(example_isolates))
expect_warning(filter_tetracyclines(example_isolates))
