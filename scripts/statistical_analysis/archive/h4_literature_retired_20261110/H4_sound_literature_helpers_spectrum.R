# Measured sound substitutions only; no route labels, binary proxies or fitted breakpoints.
if (!exists('H4_SOUND', mode='list')) stop('Source H4_sound_literature_helpers.R first.')
H4_SOUND$spectral <- c(
  'dominant_frequency_Hz','spectral_centroid_Hz','spectral_rolloff85_Hz',
  'freq_proportion_20_to_200Hz','freq_proportion_200_to_2000Hz','freq_proportion_2000_to_20000Hz',
  'octave_proportion_31_5_Hz','octave_proportion_63_0_Hz','octave_proportion_125_0_Hz',
  'octave_proportion_250_0_Hz','octave_proportion_500_0_Hz','octave_proportion_1000_0_Hz',
  'octave_proportion_2000_0_Hz','octave_proportion_4000_0_Hz','octave_proportion_8000_0_Hz')
H4_SOUND$spectrum_substitutions <- function(available_columns) {
  columns <- intersect(c(H4_SOUND$category,H4_SOUND$spectral),available_columns)
  lapply(columns,function(column) list(column=column,is_db=FALSE,
    family=if (column %in% H4_SOUND$category) 'sound_category_proportion' else 'sound_spectral_descriptor'))
}
