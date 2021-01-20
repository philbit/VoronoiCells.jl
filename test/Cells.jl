using VoronoiCells
using GeometryBasics
using Random


@testset "Cells" begin
    @testset "Simple point set far from corners" begin
        rect = Rectangle(Point2(0, 0), Point2(1, 1))

        points = [
            Point2(0.75, 0.75),
            Point2(0.25, 0.25),
            Point2(0.25, 0.75)
        ]

        tess = voronoicells(points, rect)

        @test tess.Cells[1] == [Point2(0.5, 1.0), Point2(0.5, 0.5), Point2(1.0, 0.0), Point2(1.0, 1.0)]
        @test tess.Cells[2] == [Point2(0.0, 0.5), Point2(0.0, 0.0), Point2(1.0, 0.0), Point2(0.5, 0.5)]
        @test tess.Cells[3] == [Point2(0.0, 1.0), Point2(0.0, 0.5), Point2(0.5, 0.5), Point2(0.5, 1.0)]
    end

    @testset "Point set on corners" begin
        rect = Rectangle(Point2(0, 0), Point2(1, 1))

        points = [
            Point2(0.0, 0.0),
            Point2(1.0, 0.0),
            Point2(1.0, 1.0),
            Point2(0.0, 1.0)
        ]

        tess = voronoicells(points, rect)

        @test tess.Cells[1] == [Point2(0.0, 0.5), Point2(0.0, 0.0), Point2(0.5, 0.0), Point2(0.5, 0.5)]
        @test tess.Cells[2] == [Point2(0.5, 0.5), Point2(0.5, 0.0), Point2(1.0, 0.0), Point2(1.0, 0.5)]
        @test tess.Cells[3] == [Point2(0.5, 1.0), Point2(0.5, 0.5), Point2(1.0, 0.5), Point2(1.0, 1.0)]
        @test tess.Cells[4] == [Point2(0.0, 1.0), Point2(0.0, 0.5), Point2(0.5, 0.5), Point2(0.5, 1.0)]
    end

    @testset "Random point set" begin
        Random.seed!(1)
        points = [Point2(rand(), rand()) for _ in 1:5]

        rect = Rectangle(Point2(0, 0), Point2(1, 1))

        tess = voronoicells(points, rect)

        @test tess.Cells[1] ≈ [
            Point2(0.0, 0.67254), Point2(0.0, 0.11508), Point2(0.31246, 0.18583), Point2(0.56624, 0.65872),
        ] atol = 1e-4
        @test tess.Cells[2] ≈ [
         Point2(0.0, 0.11508), Point2(0.0, 0.0), Point2(0.52699, 0.0), Point2(0.31246, 0.18583)
        ] atol = 1e-4
        @test tess.Cells[3] ≈ [
             Point2(0.60787, 0.67143), Point2(0.56624, 0.65872), Point2(0.31246, 0.18583), Point2(0.52699, 0.0), Point2(1.0, 0.0), Point2(1.0, 0.44116)
        ] atol = 1e-4
        @test tess.Cells[4] ≈ [
             Point2(0.60166, 1.0), Point2(0.60787, 0.67143), Point2(1.0, 0.44116), Point2(1.0, 1.0)
        ] atol = 1e-4
        @test tess.Cells[5] ≈ [
             Point2(0.0, 1.0), Point2(0.0, 0.67254), Point2(0.56624, 0.65872), Point2(0.60787, 0.67143), Point2(0.60166, 1.0)
        ] atol = 1e-4
    end
end

