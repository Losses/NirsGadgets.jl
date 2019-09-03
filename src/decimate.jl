using DSP

# Code from https://gist.github.com/jcbsv/1f54819708d4fcebc788

function cheby1(n, r, wp)
  # Chebyshev Type I digital filter design.
  #
  #    b, a = cheby1(n, r, wp)
  #
  # Designs an nth order lowpass digital Chebyshev filter with
  # R decibels of peak-to-peak ripple in the passband.
  #
  # The function returns the filter coefficients in length
  # n+1 vectors b (numerator) and a (denominator).
  #
  # The passband-edge frequency wp must be 0.0 < wp < 1.0, with
  # 1.0 corresponding to half the sample rate.
  #
  #  Use r=0.5 as a starting point, if you are unsure about choosing r.
  h = digitalfilter(Lowpass(wp), Chebyshev1(n, r))
  tf = convert(PolynomialRatio, h)
  coefb(tf), coefa(tf)
end


function decimate(x, r)
  # Decimation reduces the original sampling rate of a sequence
  # to a lower rate. It is the opposite of interpolation.
  #
  # The decimate function lowpass filters the input to guard
  # against aliasing and downsamples the result.
  #
  #   y = decimate(x,r)
  #
  # Reduces the sampling rate of x, the input signal, by a factor
  # of r. The decimated vector, y, is shortened by a factor of r
  # so that length(y) = ceil(length(x)/r). By default, decimate
  # uses a lowpass Chebyshev Type I IIR filter of order 8.
  #
  # Sometimes, the specified filter order produces passband
  # distortion due to roundoff errors accumulated from the
  # convolutions needed to create the transfer function. The filter
  # order is automatically reduced when distortion causes the
  # magnitude response at the cutoff frequency to differ from the
  # ripple by more than 1E–6.

  nfilt = 8
  cutoff = .8 / r
  rip = 0.05  # dB

  function filtmag_db(b, a, f)
    # Find filter's magnitude response in decibels at given frequency.
    nb = length(b)
    na = length(a)
    top = dot(exp(-1im*[0:nb-1]*pi*f), b)
    bot = dot(exp(-1im*[0:na-1]*pi*f), a)
    20*log10(abs(top/bot))
  end

  b, a = cheby1(nfilt, rip, cutoff)
  while all(b==0) || (abs(filtmag_db(b, a, cutoff)+rip)>1e-6)
    nfilt = nfilt - 1
    if nfilt == 0
        break
    end
    b, a = cheby1(nfilt, rip, cutoff)
  end
  y = filtfilt(PolynomialRatio(b, a), x)
  nd = length(x)
  nout = ceil(nd/r)
  nbeg = int(r - (r * nout - nd))
  y[nbeg:r:nd]
end
