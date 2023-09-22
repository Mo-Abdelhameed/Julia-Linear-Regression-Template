FROM julia:1.9.3

# Copy your source files and entrypoint script
COPY src ./opt/src
COPY ./entry_point.sh /opt/
COPY ./Project.toml /opt
COPY ./Manifest.toml /opt

# Set environment variables
ENV JULIA_PROJECT=/opt/
ENV JULIA_DEPOT_PATH /opt/env
ENV TMPDIR /opt/tmp

# Change ownership for the working directory
RUN chown -R 1000:1000 /opt

RUN julia -e 'using Pkg; Pkg.add(PackageSpec(uuid="336ed68f-0bac-5ca0-87d4-7b16caf5d00b"))'  # CSV
RUN julia -e 'using Pkg; Pkg.add(PackageSpec(uuid="324d7699-5711-5eae-9e2f-1d82baa6b597"))'  # CategoricalArrays
RUN julia -e 'using Pkg; Pkg.add(PackageSpec(uuid="a93c6f00-e57d-5684-b7b6-d8193f3e46c0"))'  # DataFrames
RUN julia -e 'using Pkg; Pkg.add(PackageSpec(uuid="38e38edf-8417-5370-95a0-9cbb8c7f171a"))'  # GLM
RUN julia -e 'using Pkg; Pkg.add(PackageSpec(uuid="7073ff75-c697-5162-941a-fcdaad2a7d2a"))'  # IJulia
RUN julia -e 'using Pkg; Pkg.add(PackageSpec(uuid="033835bb-8acc-5ee8-8aae-3f567f8a3819"))'  # JLD2
RUN julia -e 'using Pkg; Pkg.add(PackageSpec(uuid="682c06a0-de6a-54ab-a142-c8b1cf79cde6"))'  # JSON
RUN julia -e 'using Pkg; Pkg.add(PackageSpec(uuid="add582a8-e3ab-11e8-2d5e-e98b27df1bc7"))'  # MLJ
RUN julia -e 'using Pkg; Pkg.add(PackageSpec(uuid="a7f614a8-145f-11e9-1d2a-a57a1082229d"))'  # MLJBase
RUN julia -e 'using Pkg; Pkg.add(PackageSpec(uuid="2e2323e0-db8b-457b-ae0d-bdfb3bc63afd"))'  # MLJScientificTypes
RUN julia -e 'using Pkg; Pkg.add(PackageSpec(uuid="2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"))'  # StatsBase
RUN julia -e 'using Pkg; Pkg.add(PackageSpec(uuid="3eaba693-59b7-5ba5-a881-562e759f1c8d"))'  # StatsModels

# Make the entrypoint script executable
RUN chmod +x /opt/entry_point.sh

# Set the working directory
WORKDIR /opt/src


# Switch to a non-root user
USER 1000

# Set the entrypoint
# ENTRYPOINT ["/opt/entry_point.sh"]
ENTRYPOINT ["/bin/bash"]
