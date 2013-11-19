$:.unshift File.dirname(__FILE__) + '/../lib'
require 'lpp_t_04_matrix'
require "test/unit"
include LppT04Matrix

class Test_Matriz < Test::Unit::TestCase
        
        def setup 
                @m1 = MatrizDensa.new(2,2,[[1,2],[3,4]])
                @m2 = MatrizDispersa.new(250, 250, {100 => {10 => 1, 50 => 200}, 200 => {10 => 1, 50 => 200}})
                @m3 = MatrizDensa.new(2,2,[[2,4],[6,8]])
                @m4 = MatrizDispersa.new(250, 250, {100 => {10 => 2, 50 => 400}, 200 => {10 => 2, 50 => 400}})
                @m5 = MatrizDispersa.new(2, 2, {1 => {1 => 1, 2 => 2}, 2 => {1 => 3, 2 => 4}})
                @m6 = MatrizDispersa.new(2, 2, {1 => {1 => 7, 2 => 10}, 2 => {1 => 15, 2 => 22}})
                @m7 = MatrizDensa.new(2,2,[[7,10],[15,22]])
                @m8 = MatrizDispersa.new(2, 2, {0 => {0 => 1, 1 => 2}, 1 => {0 => 3, 1 => 4}})
                @m9 = MatrizDensa.new(2,2,[[7,10],[15,22]])
                @m10 = MatrizDispersa.new(2, 2, {0 => {0 => Frac.new(1,2), 1 => Frac.new(1,2)}, 1 => {0 => Frac.new(1,2), 1 => Frac.new(1,2)}})
                @m11 = MatrizDensa.new(2,2,[[Frac.new(3,2),Frac.new(3,2)],[Frac.new(7,2),Frac.new(7,2)]])

        end
        def test_MatrizDensa
                assert_equal("1", @m1.elemento[0][0].to_s)
                assert_equal("2", @m1.elemento[0][1].to_s)
                assert_equal("3", @m1.elemento[1][0].to_s)
                assert_equal("4", @m1.elemento[1][1].to_s)
                assert_equal(@m3.to_s, @m1.+(@m1).to_s)
                assert_equal(@m1.to_s, @m3.-(@m1).to_s)
                assert_equal(@m7.to_s, @m1.*(@m1).to_s)
        end

        def test_MatrizDispersa
                assert_equal("1", @m2.elemento[100][10].to_s)
                assert_equal("200", @m2.elemento[100][50].to_s)
                assert_equal("1", @m2.elemento[200][10].to_s)
                assert_equal("200", @m2.elemento[200][50].to_s)
                assert_equal(@m4.to_s, @m2.+(@m2).to_s)
                assert_equal(@m2.to_s, @m4.-(@m2).to_s)
                assert_equal(@m6.to_s, @m5.*(@m5).to_s)
        end

        def test_DensaDispersa
                assert_equal(@m3.to_s, @m1.+(@m8).to_s)
                assert_equal(@m1.to_s, @m3.-(@m8).to_s)
                assert_equal(@m9.to_s, @m1.*(@m8).to_s)
        end

        def test_DispersaDensa
                assert_equal(@m3.to_s, @m8.+(@m1).to_s)
                assert_equal(@m1.to_s, @m8.-(@m3).to_s)
                assert_equal(@m9.to_s, @m8.*(@m1).to_s)
        end

        def test_Fracciones
                assert_equal(@m11.to_s, @m1.*(@m10).to_s)
        end
end