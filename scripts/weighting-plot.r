
	library( "ggplot2" )

	error_bomb <- function( arg ) {
		#Difine a error exit function.
		print( "ERROR!", quote = FALSE )

		if ( arg == "no_file_name") {
			print( "Input file name and output file name are REQUIRED.", quote = FALSE )
		} else if ( arg == "inadequate_arg" ) {
			print( "Inadequate argument.", quote = FALSE )
		} else if ( arg == "no_input_file_name" ) {
			print( "Input file name is REQUIRED.", quote = FALSE )
		} else if ( arg == "no_output_file_name" ) {
			print( "Output file name is REQUIRED.", quote = FALSE )
		} else if ( arg == "invalid_circle" ) {
			print( "Size of circle must be more than 0.", quote = FALSE )
		}

		print( "Program halted!!!", quote = FALSE )

		q( "no" )
	}

	colour_type <- function( arg_c ) {

		# Default colour.
		col_list <- c(
			"#74DBEF", # Pale blue
			"#00D1FF", # Middle blue
			"#264E86"  # Deep blue
		)

		if ( arg_c == 0 ) {
			# Default.
			# Do nothing.
		} else if ( arg_c == 1 ) {
			col_list <- c(
				"#FFFF00", # Yellow
				"#FFA500", # Orange
				"#FF0000"  # Red
			)
		} else if ( arg_c == 2 ) {
			col_list <- c(
				"#1DE4BD", # Green
				"#1AC9E6", # Cyan
				"#176BA0"  # Blue
			)
		} else if ( arg_c == 3 ) {
			col_list <- c(
				"#00FF00", # Green
				"#FFFF00", # Yellow
				"#FF0000"  # Red
			)
		} else if ( arg_c == 4 ) {
			col_list <- c(
				"#FFD700", # V a p o r W a v e
				"#FF00FF", # V a p o r W a v e
				"#4158D0"  # V a p o r W a v e
			)
		} else {
		#Do nothing.
		}

		return( col_list )
	}

	args_list <- commandArgs( trailingOnly = TRUE )
	print( args_list )

	arg_len <- length( commandArgs( trailingOnly = TRUE ) )
	#print( arg_len )

	arg_i <- NULL # Input file name.
	arg_o <- NULL # Output file name.
	arg_w <- 2000 # Size of width.
	arg_h <- 1800 # Size of height.
	arg_c <- 0    # Colorize.
	arg_C <- 1.0 # Size of circle.

	if ( arg_len < 4) { error_bomb( "no_file_name" ) }

	# Command line parser.
	i <- 1
	while ( i <= arg_len ) {
		arg <- args_list[i]
		#print( arg )
		if      ( arg == "-i" ) { arg_i <- args_list[i + 1] }
		else if ( arg == "-o" ) { arg_o <- args_list[i + 1] }
		else if ( arg == "-w" ) { arg_w <- as.integer( args_list[i + 1] ) }
		else if ( arg == "-h" ) { arg_h <- as.integer( args_list[i + 1] ) }
		else if ( arg == "-c" ) { arg_c <- as.integer( args_list[i + 1] ) }
		else if ( arg == "-C" ) { arg_C <- as.numeric( args_list[i + 1] ) }
		else                    { error_bomb( "inadequate_arg" ) }

		i = i + 2
	}

	# Check file name.
	if ( is.null( arg_i ) == TRUE || is.na( arg_i ) == TRUE ) { error_bomb( "no_input_file_name" ) }
	if ( is.null( arg_o ) == TRUE || is.na( arg_o ) == TRUE ) { error_bomb( "no_output_file_name" ) }

	# Check size of circle (It must be > 0 )
	if ( arg_C <= 0 ) { error_bomb( "invalid_circle" ) }

	# Show parameters.
	msg_i <- paste( "Input file name     :", arg_i )
	msg_o <- paste( "Output file name    :", arg_o )
	msg_w <- paste( "Size of width / px  :", arg_w )
	msg_h <- paste( "Size of height / px :", arg_h )
	msg_c <- paste( "Colorize            :", arg_c )
	print( msg_i, quote = FALSE )
	print( msg_o, quote = FALSE )
	print( msg_w, quote = FALSE )
	print( msg_h, quote = FALSE )
	print( msg_c, quote = FALSE )

	# Set color types.
	col_list <- colour_type( arg_c )
	print( col_list )

	col_low  <- col_list[ 1 ]
	col_mid  <- col_list[ 2 ]
	col_high <- col_list[ 3 ]

	#Read the input file.
	dat <- read.table( arg_i, header = TRUE, sep = "\t", quote = "" )
	#print( dat )

	# Make title line short (1 : 25)
	for ( i in 1 : length( dat$title ) ) {
		if ( nchar( dat$title[ i ] ) > 25 ) {
			dat$title[ i ] <- paste( substr( dat$title[ i ], 1, 25 ), "...", sep = "" )
		}
	}
	#print( dat$title )

	####################################################################################
	# Data set for circle bar plot.
	####################################################################################

	label_data <- dat

	# Calculate the angle of each labels
	number_of_bar <- nrow( label_data )
	angle <- 90 - ( 360 * ( label_data$num - 0.5 ) / number_of_bar )
	#print( angle )
	label_data$hjust <- label_data$weight
	label_data$angle <- angle

	# Size of circle.
	size_cir = -1.0 * arg_C

	####################################################################################
	# ggplot
	####################################################################################

	output <- ggplot( data = dat, aes( x = num, y = weight, fill = weight ) ) +
	theme_void() +
	geom_bar( stat = "identity" ) +
	ylim( size_cir * max( dat$weight ), max( dat$weight ) ) +
	theme(
		axis.text = element_blank(),
		axis.title = element_blank(),
		panel.grid = element_blank()
	) +

	scale_fill_gradient2( name = "Weight", low = col_low, mid = col_mid, high = col_high, midpoint = max( dat$weight ) / 2 ) +

	coord_polar( start = 0 ) +

	geom_text(data = label_data,
		aes(x = num, y = weight, label = title, hjust = hjust),
		color = "black",
		size = 2,
		fontface = "bold",
		angle = label_data$angle,
		inherit.aes = FALSE )

	#Save the result graph.
	out_name <- paste( arg_o, ".jpg", sep = "" )

	ggsave( filename = out_name, plot = output, unit = "px", width = arg_w, height = arg_h )
	#ggsave( filename = out_name, plot = output )

	paste( out_name, "was generated." )

	print( "Program completed !!!", quote = FALSE )