# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
PYPI_NO_NORMALIZE=1
PYPI_PN="PyWavelets"

inherit distutils-r1 pypi

DESCRIPTION="Discrete Wavelet Transforms in Python"
HOMEPAGE="
	https://pywavelets.readthedocs.io/en/latest/
	https://github.com/PyWavelets/pywt/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~riscv ~x86 ~amd64-linux ~x86-linux"
IUSE="examples"

RDEPEND="
	dev-python/matplotlib[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.17.3[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
distutils_enable_sphinx doc/source \
	dev-python/numpydoc

python_test() {
	epytest "${BUILD_DIR}/lib"
}

python_install_all() {
	distutils-r1_python_install_all
	if use examples; then
		docinto examples
		dodoc -r demo
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
