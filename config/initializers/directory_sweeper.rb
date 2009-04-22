module ActionController
  module Caching

    class Sweeper

      def sweep_directory(dirs)
        dirs.each do |dir|
          cache_dir = RAILS_ROOT + "/public/#{dir}"
          FileUtils.rm_r(Dir.glob(cache_dir+"/*")) rescue Errno::ENOENT
          RAILS_DEFAULT_LOGGER.info("Cache directory '#{cache_dir}' fully swept.")
        end
      end

    end

  end
end