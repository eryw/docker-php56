FROM debian:jessie

LABEL maintainer="kristeryw@gmail.com"

# Install
RUN apt-get update && \
	DEBIAN_FRONTEND='noninteractive' apt-get install -y \
		php5-cli \
		php5-xdebug \
		php5-gd \
		php5-mcrypt \
		php5-mysql \
		php5-pgsql \
		php5-sqlite \
		php5-curl \
		php5-json \
		php5-intl \
	&& \
	sed -i 's/memory_limit\s*=.*/memory_limit=-1/g' /etc/php5/cli/php.ini && \
	sed -i 's/zend_extension=/;zend_extension=/g' /etc/php5/mods-available/xdebug.ini && \
	echo "xdebug.remote_enable = On\nxdebug.max_nesting_level = 256\nxdebug.overload_var_dump = 2\nxdebug.var_display_max_depth = 7" >> /etc/php5/mods-available/xdebug.ini && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-php-entrypoint /usr/local/bin/

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["php", "-a"]
